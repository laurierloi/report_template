# Report Template
Template repository to create project documents.

Uses UQAM citation references.

Also supports diagram generation using graphviz.

Will download required files dynamically

## Usage
```sh
make  # generate output files in output/PROJECT.docx
```

```sh
make  clean  # remove all output files and downloads
```

### Environment variables:
- PANDOC: define the pandoc runtime - default: pandoc
- PROJECT: define the mardown project file - default: project.md
- BIBLIOGRAPHY: define the biliography file - default: bibliography.bib
- BIB_STYLE: define the biliography style - default:
	universite-du-quebec-a-montreal-prenoms

## Dependencies

- pandoc

## External references:
- [Pandoc Manual](https://pandoc.org/MANUAL.html)
- [Bibtex entry types](https://www.bibtex.com/e/entry-types/)
- [Zotero CSL styles]( https://www.zotero.org/styles/ )
- [Pandoc lua Filters](https://github.com/pandoc/lua-filters) - [Includes diagram generator](https://github.com/pandoc/lua-filters/tree/master/diagram-generator)

