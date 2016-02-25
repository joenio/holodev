test:
	$(foreach test,$(wildcard tests/*_test.sh), sh $(test);)
