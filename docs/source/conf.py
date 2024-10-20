# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'Molecular Dynamics of Time-Dependent Phenomena (Module MCh WP 8)'
copyright = '2024, Kirchner group'
author = 'Kirchner group'

release = 'WISe2024'
#version = '0.1.0'

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    "sphinx_copybutton",
]

intersphinx_mapping = {
    'python': ('https://docs.python.org/3/', None),
    'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
}
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_book_theme'

html_theme_options = {
    'theme_switcher': True,
}

html_css_files = [
    "custom.css",
]

# path to custom css
html_static_path = ["_static"]

# -- Options for EPUB output
epub_show_urls = 'footnote'
