# encoding: utf-8
require_relative "../spec_helper"
require "logstash/plugin"
require "logstash/event"

describe LogStash::Filters::Uuid do

  let(:overwrite)   { false }
  let(:target)     { "target" }
  subject          { LogStash::Filters::Uuid.new( "target" => target, "overwrite" => overwrite ) }

  let(:properties) { {:name => "foo" } }
  let(:event)      { LogStash::Event.new(properties) }

  it "should register without errors" do
    plugin = LogStash::Plugin.lookup("filter", "uuid").new( "target" => target )
    expect { plugin.register }.to_not raise_error
  end

  describe "generation" do

    it "should generate an uuid field" do
      subject.filter(event)
      expect(event[target]).not_to be_nil
    end

    context "with overwrite" do

      let(:overwrite)  { true }
      let(:properties) { {target => "foo"} }

      it "should override the target field" do
        subject.filter(event)
        expect(event[target]).not_to eq("foo")
      end
    end

  end

end
