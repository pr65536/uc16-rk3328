xzcat $1 | pv | sudo dd of=$2 bs=32M ; sync
