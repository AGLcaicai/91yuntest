benchtest()
{	
	next
	apt-get >/dev/null 2>&1
	[ $? -le '1' ] && ( apt-get update | apt-get -yq install perl python automake autoconf time make gcc gdb)
	yum >/dev/null 2>&1
	[ $? -le '1' ] && yum -yq install make gcc gcc-c++ gdbautomake autoconf time perl-Time-HiRes python perl
	
	# Download UnixBench5.1.3
	if [ -s UnixBench5.1.3.tgz ]; then
		echo "UnixBench5.1.3.tgz [found]"
	else
		echo "UnixBench5.1.3.tgz not found!!!download now..."
		if ! wget -qc http://lamp.teddysun.com/files/UnixBench5.1.3.tgz; then
			echo "Failed to download UnixBench5.1.3.tgz, please download it to ${cur_dir} directory manually and try again."
			exit 1
		fi
	fi
	tar -xzf UnixBench5.1.3.tgz
	cd ${dir}/91yuntest/UnixBench/

	#Run unixbench
	make > /dev/null 2>&1
	echo "===开始测试bench===" >> ${dir}/${logfilename}
	./Run
	benchfile=`ls results/ | grep -v '\.'`
	cat results/${benchfile} >> ${dir}/${logfilename}
	echo "===bench测试结束===" >> ${dir}/${logfilename}	
	cd ..
	rm -rf UnixBench5.1.3.tgz UnixBench
}