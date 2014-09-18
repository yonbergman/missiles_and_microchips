require 'spec_helper'

require './logic/action_resolver'

describe ActionResolver do

  let(:player) { mock(:player) }
  subject { ActionResolver.new(player) }

  def r(opts)
    ActionResolver::Result.new(opts)
  end
  ZERO = ActionResolver::Result.new

  describe :block do


    before do
      player.stub(:action => :block)
    end

    context :not_under_attack do
      before { subject.stub(:anyone_attacking_me? => false)}
      its(:resolve) { should === r(player: -1) }
    end

    context :under_attack do
      before { subject.stub(:anyone_attacking_me? => true)}
      its(:resolve) { should === ZERO }
    end


  end

  describe :charge do
    before { player.stub(:action => :charge) }

    context :not_under_attack do
      before { subject.stub(:anyone_attacking_me? => false)}

      context 'target blocking' do
        before { player.stub_chain(:target, :action => :block) }
        its(:resolve) { should === r(player: 1) }
      end

      context 'target attacking' do
        before { player.stub_chain(:target, :action => :attack) }
        its(:resolve) { should === r(player: 1) }
      end

      context 'target charging' do
        before { player.stub_chain(:target, :action => :charge) }

        context 'target looking at me' do
          before { subject.stub(:target_aiming_at_me => true)}
          its(:resolve) { should === ZERO }
        end

        context 'target not looking at me' do
          before { subject.stub(:target_aiming_at_me => false)}
          its(:resolve) { should === r(player: 2) }
        end
      end
    end

    context :under_attack do
      before { subject.stub(:anyone_attacking_me? => true)}
      its(:resolve) { should === ZERO }
    end

  end

  describe :attack do
    before { player.stub(:action => :attack)}

    context 'target attacking' do
      before { player.stub_chain(:target, :action => :attack) }

      context 'target looking at me' do
        before { subject.stub(:target_aiming_at_me => true)}
        its(:resolve) { should === r(player: -1, target: -1) }
      end

      context 'target not looking at me' do
        before { subject.stub(:target_aiming_at_me => false)}
        its(:resolve) { should === r(target: -1) }
      end
    end

    context 'target blocking' do
      before { player.stub_chain(:target, :action => :block) }

      context 'target looking at me' do
        before { subject.stub(:target_aiming_at_me => true)}
        its(:resolve) { should === r(player: -2) }
      end

      context 'target not looking at me' do
        before { subject.stub(:target_aiming_at_me => false)}
        its(:resolve) { should === r(player: -1) }
      end
    end

    context 'target charging' do
      before { player.stub_chain(:target, :action => :charge) }
      its (:resolve) { should === r(target: -1)}
    end
  end

end