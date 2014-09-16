require_relative 'app'
require 'rspec'

describe DirParser do
  let (:example) { '<td><a href="Agreement_0.8-1.tar.gz">Agreement_0.8-1.tar.gz</a></td><td><a href="Agreement_0.8-3.tar.gz">Agreement_0.8-3.tar.gz</a></td>' }
  it "parses example string" do

    result = DirParser.run(example)
    expect(result).to eq( [["Agreement", "0.8-1"], ["Agreement", "0.8-3"]] )
  end
end
