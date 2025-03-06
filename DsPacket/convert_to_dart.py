import os
import re

def convert_csharp_to_dart(csharp_code, class_name):
    # 네임스페이스와 그 괄호 제거
    csharp_code = re.sub(r'namespace\s+\w+\s*{', '', csharp_code)
    csharp_code = re.sub(r'^\s*}\s*$', '', csharp_code, flags=re.MULTILINE)

    # 기본 변환 로직
    dart_code = csharp_code.replace("public class", "class")
    dart_code = dart_code.replace("public string", "String")
    dart_code = dart_code.replace("public int", "int")
    dart_code = dart_code.replace("public", "")
    dart_code = dart_code.replace("{ get; set; }", ";")
    dart_code = dart_code.replace(" : BaseRequest", " extends BaseRequest")
    dart_code = dart_code.replace(" : BaseResponse", " extends BaseResponse")

    # 추가 변환 로직
    if "BaseRequest" in class_name:
        dart_code += """
  BaseRequest(this.url, {this.token = '', this.sequence = 0});

  Map<String, dynamic> toJson() => {
        'token': token,
        'sequence': sequence,
        'url': url,
      };
"""
    elif "BaseResponse" in class_name:
        dart_code += """
  BaseResponse({this.resultCode = 0});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      resultCode: json['resultCode'],
    );
  }
"""
    else:
        # 필드 추출
        fields = re.findall(r'(\w+)\s+(\w+);', dart_code)
        field_names = [f[1] for f in fields]

        # 생성자 추가
        constructor_params = ', '.join([f'required this.{name}' for name in field_names])
        dart_code += f"""
  {class_name}({{{constructor_params}}})
      : super('api/Login');

  @override
  Map<String, dynamic> toJson() => {{
        ...super.toJson(),
"""
        for name in field_names:
            dart_code += f"        '{name}': {name},\n"
        dart_code += "      };"
    
    # 클래스 닫는 중괄호 추가
    dart_code += "\n}"

    return dart_code

def convert_file(input_file, output_file):
    with open(input_file, "r") as file:
        csharp_code = file.read()

    class_name = os.path.basename(input_file).replace(".cs", "")
    dart_code = convert_csharp_to_dart(csharp_code, class_name)

    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, "w") as file:
        file.write(dart_code)

def main():
    input_dir = "Packets"
    output_dir = "../SharedCode/dart"

    for root, _, files in os.walk(input_dir):
        for file in files:
            if file.endswith(".cs"):
                input_file = os.path.join(root, file)
                relative_path = os.path.relpath(input_file, input_dir)
                output_file = os.path.join(output_dir, relative_path).replace(".cs", ".dart")
                convert_file(input_file, output_file)

if __name__ == "__main__":
    main()