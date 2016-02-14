
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

# make all_machines and build app
stack:
	for nodes in web app-1 app-2 ; do \
		echo provisioning $$nodes ; \
		cd machines/$$nodes && vagrant up ; \
		cd machines/$$nodes && vagrant provision ; \
		cd ../../ ; \
	done

# destroy stack
destroy_stack:
	for nodes in web app-1 app-2 ; do \
		echo destroy $$nodes ; \
		cd machines/$$nodes && vagrant destroy -f ; \
		cd ../../ ; \
	done
