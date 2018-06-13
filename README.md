# Utility functions for creating and deploying lambda functions to [AWS](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)

### Usage
##### Initialize project
```
$source lambda_manager.bash
$init_lambda <nombre-proyecto>
```

##### Deploy package from virtual enviroment
```
// Inside <nombre-proyecto> folder
$deploy_lambda <nombre-proyecto> <execution-role-arn>
$deactivate
```

