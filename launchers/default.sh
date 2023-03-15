#!/bin/bash

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
echo "This is an empty launch script. Update it to launch your application."

# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE

# It fails deterministically for the first run (arm_controller cannot be loaded)
roslaunch husky_launch ur.launch &
echo 'Sleeping 10 sec before killing husky_launch/ur.launch'
sleep 10 
kill %1

tmux \
    new-session -s ur5-cartesian-control "roslaunch husky_launch ur.launch; read" \; \
    new-window -t ur5-cartesian-control:1 -n rosbridge "roslaunch rosbridge_server rosbridge_websocket.launch; read" \; \
    new-window -t ur5-cartesian-control:2 -n rosbridge-tf "rosrun tf2_web_republisher tf2_web_republisher; read" \; \
    new-window -t ur5-cartesian-control:3 -n rosbridge-controller 'sleep 5 && [[ $(read -e -p "Have you run external control? [y/N]> "; echo $REPLY) == [Yy]* ]] && rosrun controller_manager controller_manager kill arm_controller && rosrun controller_manager controller_manager start forward_cartesian_traj_controller; read' \;



