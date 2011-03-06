compile:
	@./rebar compile

clean:
	@./rebar clean

test:
	@./rebar eunit

doc:
	@./rebar doc

.PHONY: compile clean test doc
