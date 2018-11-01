To test that your account is set up correctly, type:

$ make test

First, it will test the suitability of the command:

source activate.bashrc

to run the necessary programs. If it passes, it will be sufficient 
to setup any pipeline and should be run before any analysis programs
are invoked.

Second, it will run a script that submits a small test job that should not fail,
thereby testing for configuration issues.  It will report the outcome of the 
test and email for help if it fails.
