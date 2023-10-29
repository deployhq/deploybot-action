# GitHub Action to Trigger a Deployment on DeployBot 🚀

This simple action calls the [DeployBot API](https://deploybot.com/api/deployments#trigger-deployment) to trigger a deployment on DeployBot.


## Usage

All sensitive variables should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) in the action's configuration.

### Configuration Variables

| Key                        | Value                                                                                                                                                                                                                         | Suggested Type | Required |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| ------------- | ------------- |
| `DEPLOYBOT_SUBDOMAIN`      | **Required.** Your DeployBot subdomain. For example, if your url is `https://cocacola.deploybot.com`, then it's `cocacola`.                                                                                                   | `secret` | **Yes** |
| `DEPLOYBOT_API_TOKEN`      | **Required.** The Api Token that will be used for authentication, which can be found in the right sidebar of your domain's overview page on the DeployBot dashboard. For example, `a74b8262ebae565e7572b37a94b11e27decadf05`. | `secret` | **Yes** |
| `DEPLOYBOT_ENVIRONMENT_ID` | **Required.** The DeployBot Environment ID in which the deployment will be triggered. For example, `1`.                                                                                                                       | `secret` | **Yes** |
| `DEPLOY_FROM_SCRATCH`      | **Optional.** Specifies if the deployment should be done from scratch or not. By default it's false.                                                                                                                          | `env` | No |
| `TRIGGER_NOTIFICATIONS`    | **Optional.** Specifies if the deployment should trigger notifications or not. By default it's true.                                                                                                                          | `env` | No |


### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Deploy my website in DeployBot
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:

    # Put steps here to build your site, deploy it to a service, etc.
    - name: Trigger deployment in DeployBot
      uses: facundofarias/deploybot-action@main
      env:
        # All these values should be set as encrypted secrets in your repository settings
        DEPLOYBOT_SUBDOMAIN: ${{ secrets.DEPLOYBOT_SUBDOMAIN }}
        DEPLOYBOT_API_TOKEN: ${{ secrets.DEPLOYBOT_API_TOKEN }}
        DEPLOYBOT_ENVIRONMENT_ID: ${{ secrets.DEPLOYBOT_ENVIRONMENT_ID }}
```

## License

This project is distributed under the [MIT license](LICENSE.md).