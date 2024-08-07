##===----------------------------------------------------------------------===##
##
## This source file is part of the Swift open source project
##
## Copyright (c) 2024 Apple Inc. and the Swift project authors
## Licensed under Apache License v2.0
##
## See LICENSE.txt for license information
## See CONTRIBUTORS.md for the list of Swift project authors
##
## SPDX-License-Identifier: Apache-2.0
##
##===----------------------------------------------------------------------===##

add_subdirectory(_FoundationCShims)

# Macros are only useful for development, but not at runtime.
option(SwiftFoundation_BUILD_MACROS "Include SwiftFoundation Macro Targets" ON)
message(STATUS "Build macros: ${SwiftFoundation_BUILD_MACROS}")
if(SwiftFoundation_BUILD_MACROS)
  add_subdirectory(FoundationMacros)
endif()

add_subdirectory(FoundationEssentials)
add_subdirectory(FoundationInternationalization)
