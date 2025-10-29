# Check for repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Try origin first
remote_url=$(git remote get-url origin 2>/dev/null || git remote get-url $(git remote | head -n1) 2>/dev/null)

if [ -z "$remote_url" ]; then
    echo "Error: No remote repository found"
    exit 1
fi

# Try HTTPS if needed
if [[ $remote_url == git@* ]]; then
    remote_url=$(echo "$remote_url" | sed 's/git@\([^:]*\):/https:\/\/\1\//' | sed 's/\.git$//')
elif [[ $remote_url == https://* ]]; then
    remote_url=$(echo "$remote_url" | sed 's/\.git$//')
fi

echo "Opening: $remote_url"

# Open the URL in the default browser
case "$(uname -s)" in
    Linux*)     xdg-open "$remote_url" ;;
        *)          echo "Unsupported OS. Please open manually: $remote_url" ;;

esac

