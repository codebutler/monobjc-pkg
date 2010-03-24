#!/bin/bash

DIR=/Library/Frameworks/Mono.framework/Versions/Current/lib/mono/monobjc
 
gacutil -u Monobjc
gacutil -u Monobjc.Cocoa

gacutil -i $DIR/Monobjc.dll -package monobjc
gacutil -i $DIR/Monobjc.Cocoa.dll -package monobjc