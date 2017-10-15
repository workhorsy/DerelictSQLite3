
# Stop and exit on error
set -e

VERSION="0.2.0"

cd ..
sed 's/$VERSION/'$VERSION'/g' tools/README.template.md > README.md

# Generate documentation
<<TURN_OFF_DOCS
dub --build=docs
mkdir docs/$VERSION
mv docs/DerelictSQLite3.html docs/$VERSION/index.html
git add docs/$VERSION/
TURN_OFF_DOCS

# Create release
git commit -a -m "Release $VERSION"
git push

# Create and push tag
git tag v$VERSION -m "Release $VERSION"
git push --tags
