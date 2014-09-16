require_relative '../app'
require 'rspec'

describe PackageRepository do
  let (:repo) { PackageRepository.new("packages_test") }
  let (:name) { "aaa" }
  let (:pkg) { Entities::Package.new(name: name, version: "1.0", authors:[], maintainers: []) }

  before do
    repo.collection.remove
  end

  it "stores package" do
    expect { repo.store_new(pkg) }.to change { repo.collection.find.to_a.size }.from(0).to(1)
  end

  it "updates version of package" do
    expect { repo.add_version(pkg, "1.2") }.not_to change { repo.collection.find.to_a.size }
    expect { repo.add_version(pkg, "1.2") }.to change { repo.find_by_name(name).versions }
  end

  it "finds package by name" do
    stored_pkg = repo.find_by_name(name)
    expect(stored_pkg).to be_nil

    repo.store_new(pkg)
    stored_pkg = repo.find_by_name(name)
    expect(stored_pkg.name).to eql(name)
  end
end
