
symFiles=authorized_keys known_hosts

.PHONY: install symlinks

install: symlinks $(HOME)/.ssh/config

symlinks:
	@$(foreach f,$(symFiles), [ "$(PWD)/$f" = `readlink $(HOME)/.ssh/$f` ] || (rm -f $(HOME)/.ssh/$f; ln -v -f -n -s $(PWD)/$f $(HOME)/.ssh/ ) ;  )

$(HOME)/.ssh/config: config.sh
	./config.sh > $@
