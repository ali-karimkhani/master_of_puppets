
# web | app-1 | app-2
ROLE?=

##
# Builds local VM.
#
# make machine (ROLE=web | ROLE=app-1 | ROLE=app-2)
machine:
	cd machines/$(ROLE) && vagrant up
	cd machines/$(ROLE) && vagrant provision
	cd machines/$(ROLE) && vagrant ssh

# Destroty machine
# make destroy_machine (ROLE=web | ROLE=app-1 | ROLE=app-2)
destroy_machine:
	@cd machines/$(ROLE); \
	vagrant destroy

# make all_machines
all_machines:
	for nodes in web app-1 app-2 ; do \
		cd machines/$(nodes) && vagrant up ; \
		cd machines/$(nodes) && vagrant provision ; \
	done
