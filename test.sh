while [ "$1" != "" ]; do
	case $1 in
		-p )           shift
			PRECISION_LIST=$1
			;;
		-r )           shift
			ROUTINE_LIST=$1
			;;
		-l )           shift
			LEVEL_LIST=$1
			;;
		* )
		;;
	esac
	shift
done

if [ -z $PRECISION_LIST ]; then

#rscal dotc dotu rotmg rotm
mkdir -p output
for rout in rotg rot nrm2 amax asum scal axpy copy swap dot dsdot sdsdot rotm rotmg; do
	for size in 0 1 2 3 7 15 31 63 127 255 511 1023 2047 4095 8191 16383 32767 65535; do
		echo Running Single Precision $rout for $size
		./xsl1blastst -R $rout \
			-a 3 0 1 0.5 \
			-X 2 1 2 \
			-Y 2 1 2 \
			-n $size \
			> output/s1$rout$size.out
	done
done


mkdir -p output
for rout in rotg rot nrm2 amax asum scal axpy copy swap dot rotm rotmg; do
	for size in 0 1 2 3 7 15 31 63 127 255 511 1023 2047 4095 8191 16383 32767 65535; do
		echo Running Double Precision $rout for $size
		./xdl1blastst -R $rout \
			-a 3 0 1 0.5 \
			-X 2 1 2 \
			-Y 2 1 2 \
			-n $size \
			> output/d1$rout$size.out
	done
done


mkdir -p output
for rout in rotg rot nrm2 amax asum scal axpy copy swap rscal dotc dotu; do
	for size in 0 1 2 3 7 15 31 63 127 255 511 1023 2047 4095 8191 16383 32767 65535; do
		echo Running Complex Single Precision $rout for $size
		./xcl1blastst -R $rout \
			-a 3 0 0 1 1 0.5 0.5 \
			-X 2 1 2 \
			-Y 2 1 2 \
			-n $size \
			> output/c1$rout$size.out
	done
done

mkdir -p output
for rout in rotg rot nrm2 amax asum scal axpy copy swap rscal dotc dotu; do
	for size in 0 1 2 3 7 15 31 63 127 255 511 1023 2047 4095 8191 16383 32767 65535; do
		echo Running Complex Double Precision $rout for $size
		./xzl1blastst -R $rout \
			-a 3 0 0 1 1 0.5 0.5 \
			-X 2 1 2 \
			-Y 2 1 2 \
			-n $size \
			> output/z1$rout$size.out
	done
done

else

if [ $LEVEL_LIST == "1" ]; then
	SIZE_LIST = 0 1 2 3 7 15 31 63 127 255 511 1023 2047 4095 8191 16383 32767 65535
else
	SIZE_LIST = 0 1 2 3 7 15 31 63 127 255 511 1023
fi
fi
