import hcl
import subprocess
import argparse

parser = argparse.ArgumentParser(description="Stack Name")

parser.add_argument("-s", "--user_input", type=str, help="Stack Name")

args = parser.parse_args()

stack_name = args.user_input
stack_name = str(stack_name)

dir_path="/Users/dhruvins/.jenkins/jobs/Build_Stack_Terraform/workspace/Stack_Definition/"
file_name="/terraform.tfvars"

tfvars_file = dir_path+stack_name+file_name

def get_account_name_from_tfvars(tfvars_file):

    try:
        with open(tfvars_file, 'r') as f:
        # Load the contents of the terraform.tfvars file into a dictionary
            tfvars_data = hcl.load(f)

            # Check if the 'account_name' key exists or not
            if 'account_name' in tfvars_data:
                return tfvars_data['account_name']
            else:
                return "dhsoni"

    except FileNotFoundError:
        return f"File {tfvars_file} not found."


# Call the function and store the result in a variable
account_name = get_account_name_from_tfvars(tfvars_file)

# Print the result
print(account_name)
