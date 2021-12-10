import os
import argparse
import subprocess
import yaml


class GenerateSchema:
    def run_command(self, command):
        process = subprocess.Popen(
            command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

        while process.stdout.readable():
            line = process.stdout.readline()

            if not line:
                break

            print(line.decode('utf-8').rstrip())

    def parse_yaml(self, yaml_full):
        for item in yaml_full:
            # print(item)
            if item == "variables":
                return yaml_full[item]

    def parse_variables(self, variables):
        for variable in variables:
            value = variables[variable]
            new_title = ' '.join(elem.capitalize()
                                 for elem in variable.split('_'))
            value["title"] = new_title
            print(value)

    def write_yaml(self, yaml_full):

        with open(r'output.yaml', 'w') as file:
            documents = yaml.dump(yaml_full, file, sort_keys=False)

    def run_all(self):
        # modules = [name for name in os.listdir(".") if os.path.isdir(name)]
        # output = []
        # for module in modules:
        #     output = self.run_command(f"terraform-docs yaml {module}")
        with open("schema.yaml", "r") as stream:
            try:
                yaml_full = yaml.safe_load(stream)
                variables = self.parse_yaml(yaml_full)
                self.parse_variables(variables)
                self.write_yaml(yaml_full)
            except yaml.YAMLError as exc:
                print(exc)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Generate Resource Manager Schema")
    # parser.add_argument('-t', '--tf_path',
    #                     required=True,
    #                     help="JSON configuration. (generated from `terraform output -json)"
    #                          " A filename of '-' reads from stdin.")

    args = parser.parse_args()
    generate_schema = GenerateSchema()
    generate_schema.run_all()
