#!/bin/bash
#
# (c) Lutfi Akdag (aka Mbtt) - 2025
# APKEditor Control Script
#

# Apk Handler
echo "Enter App Name:"
read -r app
echo " "
echo "Appname is: ${app}"
echo " "
echo "************************"

xapkfilename="$app.xapk"

apkfilename="$app.apk"
mergedapkfilename=$app'_merged.apk'
mandfapkfilename=$app'_merged_refactored.apk'

apkfilepath=$app'_decompile_xml'
mergedapkfilepath=$app'_merged_decompile_xml'
mandfapkfilepath=$app'_merged_refactored_decompile_xml'

# Command Table
echo "************************"
echo " "
echo "1) Decompile"
echo " "
echo "2) Recompile"
echo " "
echo "3) Merge"
echo " "
echo "4) Refactor"
echo " "
echo "5) Protect"
echo " "
echo "6) Info"
echo " "
echo "************************"

# Main
execute () {
    read -r command
    # Decompile
    if [ $command == "1" ]; then
        if [ -e "$apkfilename" ]; then
            java -jar APKEditor.jar d -i $apkfilename
        elif [ ! -e "$apkfilename" ]; then
            java -jar APKEditor.jar d -i $mergedapkfilename
            if [ ! -e "$mergedapkfilename" ]; then
                java -jar APKEditor.jar d -i $mandfapkfilename
            fi
        else
            echo "Uygulama bulunamadı..."
        fi
    # Recompile
    elif [ $command == "2" ]; then
        if [ -d "$apkfilepath" ]; then
            java -jar APKEditor.jar b -i $apkfilepath
        elif [ ! -d "$apkfilepath" ]; then
            java -jar APKEditor.jar b -i $mergedapkfilepath
            if [ ! -d "$mergedapkfilepath" ]; then
                java -jar APKEditor.jar b -i $mandfapkfilepath
            fi
        else
            echo "Klasör bulunamadı..."
        fi
    # Merge
    elif [ $command == "3" ]; then
        java -jar APKEditor.jar m -i $xapkfilename
    # Refactor
    elif [ $command == "4" ]; then
        if [ -e "$apkfilename" ]; then
            java -jar APKEditor.jar x -i $apkfilename
        elif [ ! -e "$apkfilename" ]; then
            java -jar APKEditor.jar x -i $mergedapkfilename
        else
            echo "Uygulama bulunamadı..."
        fi
    # Protect
    elif [ $command == "5" ]; then
        if [ -e $app'_decompile_xml_out.apk' ]; then
            java -jar APKEditor.jar p -i $app'_decompile_xml_out.apk'
        elif [ ! -e $app'_decompile_xml_out.apk' ]; then
            java -jar APKEditor.jar p -i $app'_merged_decompile_xml_out.apk'
            if [ ! -e $app'_merged_decompile_xml_out.apk' ]; then
                java -jar APKEditor.jar p -i $app'_merged_refactored_decompile_xml_out.apk'
                if [ ! -e $app'_merged_refactored_decompile_xml_out.apk' ]; then
                    java -jar APKEditor.jar p -i $app'_refactored_merged_decompile_xml_out.apk'
                fi
            fi
        else
            echo "Uygulama bulunamadı..."
        fi
    # Info
    elif [ $command == "6" ]; then
        java -jar APKEditor.jar info -v -resources -i $apkfilename
    # Exit
    elif [ $command == "exit" ]; then
        exit
    fi
}

# Execute
while :
do
    execute
done

