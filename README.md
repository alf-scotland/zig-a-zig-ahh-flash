# Zig-a-zig-ahh flashing

This repository is a little suggar wrapper around the flashing instructions found [here](https://www.zigbee2mqtt.io/information/supported_adapters.html#electrolama-zig-a-zig-ah-zzh).

## Getting started

Create an environment file `.env` that sets the port of the zig-a-zig-ahh stick:

```shell
# .env
PORT="<replace-with-port>"
```

Alternatively, you can also set the port of the device using the environment variable `PORT`. See below how to discover the port the stick is connected through.

You will also need the install the virtual environment using [pipenv](https://pipenv.pypa.io/):

```sh
make install
```

To flash a program you can use one of the two commands:

* `make flash-blink` for the blink program
* `make flash-coordinator` for the Z-Stack coordinator

## Determining the port of the device

If you do not know your port, try running `make discover-port`. The output will look like this:

```
Press any key to continue after device is connected.

> cu.usbserial-143220
> tty.usbserial-143220
```

Use the *tty* port, i.e. `PORT=/dev/tty.usbserial-143220`.
