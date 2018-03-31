---
layout: post
title: moveit_core源码阅读
categories: [moveit]
tags: [c++, 开发，moveit]
redirect_from:
  - /2017/09/21
---

来自： http://docs.ros.org/indigo/api/moveit_core/html/namespaces.html

|命名空间   |  解释 |
| -----------|:-------:|
|collision_detection|	Generic interface to collision detection|
|collision_detection::AllowedCollision	|Any pair of bodies can have a collision state associated to it|
|collision_detection::BodyTypes|	The types of bodies that are considered for collision|
|constraint_samplers|	The constraint samplers namespace contains a number of methods for generating samples based on a constraint or set of constraints|
|distance_field	|Namespace for holding classes that generate distance fields|
|dynamics_solver	|This namespace includes the dynamics_solver library|
|kinematic_constraints	|Representation and evaluation of kinematic constraints|
|kinematics	|API for forward and inverse kinematics|
|kinematics::DiscretizationMethods	||
|kinematics::KinematicErrors	||
|kinematics_metrics	|Namespace for kinematics metrics|
|moveit	|Main namespace for MoveIt!|
|moveit::core	|Core components of MoveIt!|
|moveit::tools|	This namespace includes classes and functions that are helpful in the implementation of other MoveIt components. This is not code specific to the functionality provided by MoveIt
|moveit_controller_manager|	Namespace for the base class of a MoveIt controller manager
|moveit_sensor_manager	|Namespace for the base class of a MoveIt sensor manager
|planning_interface	|This namespace includes the base class for MoveIt planners
|planning_request_adapter	|Generic interface to adapting motion planning requests
|planning_scene	|This namespace includes the central class for representing planning contexts
|pr2_arm_kinematics	||
|robot_trajectory	||
|trajectory_processing||


## moveit的几个比较重要的命名空间：

## moveit::core

|类名|解释|
|--------|:--------:|
|AttachedBody | 	Object defining bodies that can be attached to robot links. This is useful when handling objects picked up by the robot.|
|FixedJointModel ||
|FloatingJointModel||
|JointModel | A joint from the robot. Models the transform that this joint applies in the kinematic chain. A joint consists of multiple variables. In the simplest case, when the joint is a single DOF, there is only one variable and its name is the same as the joint's name. For multi-DOF joints, each variable has a local name (e.g., x, y) but the full variable name as seen from the outside of this class is a concatenation of the "joint name"/"local name" (e.g., a joint named 'base' with local variables 'x' and 'y' will store its full variable names as 'base/x' and 'base/y'). Local names are never used to reference variables directly.
|JointModelGroup||
|LinkModel | A link from the robot. Contains the constant transform applied to the link and its geometry.||
|PlanarJointModel|
|PrismaticJointModel|
|RevoluteJointModel|
|RobotModel | Definition of a kinematic model. This class is not thread safe, however multiple instances can be created.|
|RobotState | Representation of a robot's state. This includes position, velocity, acceleration and effort.|
|Transforms | Provides an implementation of a snapshot of a transform tree that can be easily queried for transforming different quantities. Transforms are maintained as a list of transforms to a particular frame. All stored transforms are considered fixed. |
|VariableBounds


![jointmodel继承关系](/assets/images/pics/jointmodel继承关系.png "jointmodel继承关系")

## planning_scene

|类名|解释|
|--------|:--------:|
|PlanningScene | This class maintains the representation of the environment as seen by a planning instance. The environment geometry, the robot geometry and state are maintained.|
|SceneTransforms|

## planning_interface

|类名|解释|
|--------|:--------:|
|PlannerManager| 	Base class for a MoveIt planner.|
|PlanningContext| 	Representation of a particular planning context -- the planning scene and the request are known, solution is not yet computed. |

## 重要的大类

|类名|解释|
|--------|:--------:|
|RobotModel | 我们可以看到在moveit::core这个命名空间下面都是最最基础的几个类。由于机器人都是由关节和连杆构成的。所以先构建了JointModel这个基类，我们从上图可以看到由这个基类出发衍生出来旋转关节固定关节浮动关节平面关节等等。同时候对于连杆系统，构建了LinkModel这个类。将这些关节和连杆联合联合起来构成了关节组JointModelGroup，这个就是串联机械臂的抽象了他和机器人书上描述的一样包含了一系列参数，变换等等。根据JointModelGroup又构建了RobotModelGroup，可以认为一个机器人并不是只有一条运动学链，它有双臂机器人，有gripper的驱动链等等。所以把上述的所有的模型混合起来，构建出这个整体的RobotModel。而我们要做的不是仅仅对机器人建模，我们需要将机器人的时间关系表现出来，抽象的每个时间点上面就是去描述一个机器人的状态，这个状态不光包括位置，速度，加速度，还包括自身的碰撞，机器人运动学等等的信息。所以RobotState是最高层的一个类它囊括了上面描述的所有的类。可以看到这就是一个层层抽象，由下到上的组合的过程。还是非常的精妙的～|
|RobotState | 是综合的一个机器人在该时间点的描述，是机器人描述的最高层。|
|PlanningScene | 这个类描述了机器人周围的环境，由RobotModel这个类构造。主要是用于检测机器人是否与环境有着碰撞。这个还并不是很了解，到此为止啦。|
|PlanningContext | 它包括了PlanningScene和request，也就是说它通过planning_interface接受目标的请求，|

































