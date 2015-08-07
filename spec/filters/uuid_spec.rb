require "logstash/devutils/rspec/spec_helper"
require 'logstash/filters/uuid'

describe LogStash::Filters::Uuid do
  describe "add field" do
    config <<-CONFIG
      filter {
        uuid {
          target => "uuid"
        }
      }
    CONFIG

    sample("foo" => "bar") do
      expect(subject["uuid"]).not_to be_nil
    end
  end

  describe "do not overwrite" do
    config <<-CONFIG
      filter {
        uuid {
          target => "uuid"
        }
      }
    CONFIG

    sample("uuid" => "foobar") do
      expect(subject["uuid"]).to eq("foobar")
    end
  end

  describe "do overwrite" do
    config <<-CONFIG
      filter {
        uuid {
          target => "uuid"
          overwrite => true
        }
      }
    CONFIG

    sample("uuid" => "foobar") do
      expect(subject["uuid"]).not_to be_nil
      expect(subject["uuid"]).not_to eq("foobar")
    end
  end

end
