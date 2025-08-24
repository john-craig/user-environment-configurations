#!/bin/bash
lsof -Fn -c soffice | grep -E '\.(odt|ods|odp|docx|xlsx|pptx)$' | sed 's/^n//'