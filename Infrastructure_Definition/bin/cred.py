import hcl

# Define the path to the terraform.tfvars file
tfvars_file = "${WORKSPACE}/Stack_Definition/${env.stack_name}/terraform.tfvars"
print(tfvars_file)

def get_account_name_from_tfvars(tfvars_file):
    try:
        with open(tfvars_file, 'r') as f:
            # Load the contents of the terraform.tfvars file into a dictionary
            tfvars_data = hcl.load(f)

            # Check if the 'account_name' key exists or not
            if 'account_name' in tfvars_data:
                return tfvars_data['account_name']
            else:
                return None

    except FileNotFoundError:
        return f"File {tfvars_file} not found."

# Call the function and store the result in a variable
account_name = get_account_name_from_tfvars(tfvars_file)

# Print the result
print(account_name)
