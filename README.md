# Tech Challenge - AWS Foundation


### Run Environment

You will need to have an aws account created and configured to be accessed through your machine under profile named `tech-challenge`.

After that, follow these steps:

1 - create a bucket where terraform state will be placed

```sh
aws s3api create-bucket --bucket tc-g13-tf-state --profile tech-challenge
```

This command will create a bucket named tc-g13-tf-state where all terraform states will be placed.

Now we can initialize terraform

2 - initialize terraform

```sh
terraform init
```

Now we can provision environment

3 - provision environment

```sh
terraform plan #will analyze what will be made
terraform apply #apply script (creating, changing or destroying components)
```