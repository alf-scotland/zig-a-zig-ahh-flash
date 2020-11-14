BLINK_URL=https://electrolama.com/_assets/blink.bin
Z_STACK_PROGRAM=CC26X2R1_20201026
Z_STACK_URL="https://github.com/Koenkk/Z-Stack-firmware/raw/master/coordinator/Z-Stack_3.x.0/bin/${Z_STACK_PROGRAM}.zip"

fetch-blink:  ## fetch the blink program
	@curl -s -o firmware/blink.bin "${BLINK_URL}" && \
	echo "Downloaded blink program."

fetch-coordinator:  ## fetch the coordinator program
	@curl -sL -o firmware/.z-stack.zip "${Z_STACK_URL}" && \
	echo "Downloaded coordinator program (${Z_STACK_PROGRAM})." && \
	unzip -oq firmware/.z-stack.zip -d firmware/ && \
	echo "Inflated coordinator program." && \
	rm -f firmware/.z-stack.zip

flash-blink: fetch-blink  ## flash blink program
	pipenv run cc2538-bsl.py -p "${PORT}" -evw "firmware/blink.bin"

flash-coordinator: fetch-coordinator  ## flash coordinator program
	pipenv run cc2538-bsl.py -p "${PORT}" -evw "firmware/${Z_STACK_PROGRAM}.hex"

install:  ## install the pipenv environment
	pipenv install

discover-port:  ## discover the USB port to which the device is connected
	@ls -1 /dev/ > .dev.1.txt && \
	echo "Press any key to continue after device is connected." && \
	read -n 1 && \
	ls -1 /dev/ > .dev.2.txt && \
	diff .dev.[12].txt | grep ">" && \
	rm -f .dev.[12].txt
