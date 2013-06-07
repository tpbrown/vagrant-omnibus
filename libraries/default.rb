#
#  This code monkey patches Chef 11's is_omnibus method to treat the embedded ruby in Vagrant as an Omnibus install.
#  Desired output is that Vagrant's ruby *does not* get Gems installed unless you use chef_gem
#
Chef::Log.info("WARNING: Monkey patching is_omnibus method to support embedded Chef in Vagrant.")

class ::Chef::Provider::Package::Rubygems
  # Store the original method so we can call it
  alias_method :chef11_is_omnibus?, :is_omnibus?
  
  # New method that does the normal Chef 11 is_omnibus check, and only if false do we check for Vagrant
  def is_omnibus?
    if !chef11_is_omnibus?
      if RbConfig::CONFIG['bindir'] =~ %r!/opt/vagrant_ruby/bin!
        Chef::Log.debug("#{@new_resource} detected Vagrant embedded installation in #{RbConfig::CONFIG['bindir']}")
        # Vagrant embeds ruby and chef-solo.  Treat it like an Omnibus install [don't change it]
        true
      else
        Chef::Log.debug("#{@new_resource} detected normal installation in #{RbConfig::CONFIG['bindir']}")
        false
      end
    end
  end
end

# I couldn't get the Object.send monkey-patch approach working so we're just overloading the old nasty way.
# Chef::Provider::Package::Rubygems.send :include, VagrantEmbeddedChef
