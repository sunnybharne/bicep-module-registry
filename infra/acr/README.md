# ACR

# Bicep BestPractices
1.Use your organizations naming conventions for parameter declaration.
2.Use parameters for settings that change between deployments. Variables and hard-coded values can be used for settings that don't change between deployments.
3.Make sure the default values are safe for anyone to deploy. For example, consider using low-cost pricing tiers and SKUs so that someone deploying the template to a test environment doesn't incur a large cost unnecessarily.
4.Use the @allowed decorator sparingly. If you use this decorator too broadly, you might block valid deployments. As Azure services add SKUs and sizes, your allowed list might not be up to date. For example, allowing only Premium v3 SKUs might make sense in production, but it prevents you from using the same template in non-production environments.
5.Provide descriptions for your parameters. 
6.Use // comments to add notes within your Bicep files.
7.Put Parameter declaration at the top of the bicep file.
8.Specify minimum and maximum character length for parameters that control naming.
9.Plan your parameters to make your templates easy to deploy.
