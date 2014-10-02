include $(PQ_FACTORY)/factory.mk

pq_module_name := gc-7.2
pq_module_file := $(pq_module_name)f.tar.gz
pq_configure_args :=			\
	--prefix=$(part_dir)		\
	--enable-threads=posix		\
	--enable-thread-local-alloc	\
	--enable-parallel-mark		\
	--disable-dependency-tracking	\
	--enable-large-config		\
	--enable-handle-fork		\
	--enable-gc-assertions

build-stamp: stage-stamp
	$(MAKE) -C $(pq_module_name) && \
	$(MAKE) -C $(pq_module_name) check && \
	$(MAKE) -C $(pq_module_name) install DESTDIR=$(stage_dir) && \
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	(cd $(pq_module_name) && ./configure $(pq_configure_args)) && touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp:
	tar xf $(source_dir)/$(pq_module_file) && touch $@
