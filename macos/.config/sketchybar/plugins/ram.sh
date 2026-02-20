#!/bin/bash
# Get memory info in pages
PAGE_SIZE=$(sysctl -n vm.pagesize)
PAGES_APP=$(sysctl -n vm.page_pageable_internal_count)
PAGES_WIRED=$(sysctl -n vm.page_wire_count)
PAGES_COMPRESSED=$(sysctl -n vm.page_compressor_count)
TOTAL_MEM=$(sysctl -n hw.memsize)

# Calculate used memory
USED_MEM=$(( (PAGES_APP + PAGES_WIRED + PAGES_COMPRESSED) * PAGE_SIZE ))
PERCENTAGE=$(( 100 * USED_MEM / TOTAL_MEM ))

sketchybar --set $NAME label="${PERCENTAGE}%"
