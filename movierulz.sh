#!/bin/sh
echo "Enter some text:"
read query

# Replace spaces with '+'
formatted=$(printf '%s' "$query" | tr ' ' '+')
data=$(xidel https://www.watchmovierulz.sh/search_movies?s=$formatted -s -e "//div[@class='boxed film']//a[@title and @href]/@href")
# Read the data into an array
IFS=$'\n' read -r -d '' -a options <<< "$data"

# Display the menu
echo "Select an option:"
select option in "${options[@]}"; do
    # Check if a valid option number was selected
    if [[ -n $option ]]; then
        echo "You selected: $option"
        break
    else
        echo "Invalid option. Please try again."
    fi
done
magnet=$(xidel "$option" -s -e "//a[contains(@href, 'magnet:')][contains(@href, '1080p')]/@href")
echo $magnet
