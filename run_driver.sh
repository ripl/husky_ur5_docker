#!/bin/bash
roslaunch husky_description description.launch &
cpk run -M -f --net=host -- --group-add 1002 --cap-add SYS_NICE
