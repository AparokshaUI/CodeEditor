docs:
	@sourcedocs generate --min-acl private -r --spm-module CodeEditor --output-folder Documentation/CodeEditor

swiftlint:
	@swiftlint --autocorrect

format:
	@clang-format -i Sources/CCodeEditor/shim.h  --style=file
