require "helper"
describe Potemkin::AndroidBuilder do

  before do
    @builder = Potemkin::AndroidBuilder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :android_project_dir => "dir", :build_type => "debug"))
  end

  it "should run the build command with the android home set" do
    android_home = "UNKNOWN"
    @builder.with_env_vars("ANDROID_HOME" => "~/her-o") do
      android_home = ENV["ANDROID_HOME"]
    end
    assert_equal "~/her-o", android_home
  end

  it "should run a build command" do
    command = "ant -f dir/build.xml debug"
    Potemkin.expects(:run).with(command).once
    @builder.build
  end

  it "should run a clean command" do
    command = "ant -f dir/build.xml clean"
    Potemkin.expects(:run).with(command).once
    @builder.clean
  end




end