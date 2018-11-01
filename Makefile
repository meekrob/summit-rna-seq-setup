test:
	@echo "Testing job submission"
	@cd .test_environ && bash test_job_submission.bash

fail:
	@echo "Testing failure"
	@cd .test_environ && bash test_job_submission.bash fail
