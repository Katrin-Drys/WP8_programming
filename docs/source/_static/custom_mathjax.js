MathJax = {
    tex: {
        tags: 'all',  // Use all labels
        tagSide: 'right',  // Align tags to the right
    },
    options: {
        renderActions: {
            addLabel: [200, function (doc) {
                for (const math of doc.math) {
                    if (math.display && math.root.tag) {
                        math.typesetRoot.parentNode.setAttribute(
                            'data-label',
                            '\\(' + math.root.tag + '\\)'
                        );
                    }
                }
            }, '']
        }
    }
};
