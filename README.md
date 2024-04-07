This repo is built just to be able to convert .xacro files into .urdf files.
Essentially, we're using docker here to be able to run xacro, which requires ros1. By using Docker, we can run xacro on any OS that does not support ros1.

I used it personally to compile the .xacro file in the fuji_mecanum folder.

### Step 1: Build the dockerfile.

Use:
```docker build --build-arg ROBOT_PROJECT_FOLDER=<yourrobotfolderpath> --build-arg ROBOT_FILENAME=<yourxacrofile.xacro> -t xacro-ros-create-urdf .```

E.g.
```docker build --build-arg ROBOT_PROJECT_FOLDER=./fuji_mecanum/ --build-arg ROBOT_FILENAME=mecanum_wheel_right.xacro  -t xacro-ros-create-urdf .```

The ```<yourxacrofile.xacro>``` file needs to be in the folder ```<yourrobotfolderpath>```. All dependencies (robot parts) need to be rooted also in ```<yourrobotfolderpath>```.


### Step 2: Run.
Use:
```docker run -v $(pwd)/share:/home/share -it --name xacro-ros-create-urdf-instance -e ROBOT_PROJECT_FOLDER=<yourrobotfolderpath> -e ROBOT_FILENAME=<yourxacrofile.xacro> xacro-ros-create-urdf```

E.g.
```docker run -v $(pwd)/share:/home/share -it --name xacro-ros-create-urdf-instance -e ROBOT_PROJECT_FOLDER="fuji_mecanum" -e ROBOT_FILENAME="mecanum_wheel_right.xacro" xacro-ros-create-urdf```"

(You can also choose a different name).


If you run this docker command multiple times, you may find that you need to first purge the old name.

After completion, .urdf file should be in the ```/share``` folder.
