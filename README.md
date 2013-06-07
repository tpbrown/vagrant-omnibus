vagrant-omnibus Cookbook
========================
This cookbook monkey patches Chef to treat Vagrant's embedded Ruby as an omnibus install.

You might want this if your recipe installs another Ruby and you want gem_package in community cookbooks
to install to *that* ruby and not /opt/vagrant_ruby.

Chef normally prevents installing into the Ruby actually running Chef via the is_omnibus? method. 
If an omnibus install is detected you must use chef_gem to install a gem into the embedded ruby.

Usage
-----
#### vagrant-omnibus::default
Just include_recipe 'vagrant-omnibus'

You should see "INFO: WARNING: Monkey patching is_omnibus method to support embedded Chef in Vagrant." in the Chef logs.

If Chef logging is set to debug you will see "detected" messages indicating if the ruby instance detect is omnibus or normal.

Tested only on Chef 11.

License and Authors
-------------------
Authors: Tim Brown, tpbrown@gmail.com
