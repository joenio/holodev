test:
	$(foreach test,$(wildcard tests/*_test.sh), sh $(test);)

test-minimal:
	sh tests/minimal_test.sh

test-vagrant:
	vagrant up
	@for machine in $(shell vagrant status | awk '$$2 == "running" {print $$1}'); do\
		echo "";\
		echo "+++ running holodev tests under $$machine +++";\
		echo "";\
		vagrant ssh $$machine -- 'cd /vagrant && make test';\
	done
