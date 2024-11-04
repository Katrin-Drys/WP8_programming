window.MathJax = {
    tex: {
        tags: 'ams', // Use AMS-style labels to suppress default top labels
    },
    options: {
        renderActions: {
            addCustomLabel: [200, function (doc) {
                for (const math of doc.math) {
                    if (math.display && math.root.tag) {
                        // Set the custom data-label attribute for the right-aligned label
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
