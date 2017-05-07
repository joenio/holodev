all:
	@echo "nothing to do"

manpage:
	@pod2man -c Holodev\ Manual -r Holodev\ $$(./holodev --version) holodev > holodev.1
	@pod2markdown holodev holodev.1.md

test:
	$(foreach test,$(wildcard tests/*_test.sh), sh $(test);)

test-minimal:
	sh tests/minimal_test.sh

test-vagrant:
	@for machine in $$(vagrant status | awk '$$2 == "running" {print $$1}'); do\
		echo "";\
		echo "+++ running holodev tests under $$machine +++";\
		echo "";\
		vagrant ssh -c 'cd /vagrant && make test' $$machine;\
	done

clean:
	rm -f *.1 *.tmp
