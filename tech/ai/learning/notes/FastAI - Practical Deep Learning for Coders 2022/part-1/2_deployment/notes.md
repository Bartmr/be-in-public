## You train a model before you clean the data, to debug the quality of the data

### Confusion Matrix

You debug the data using a _confusion matrix_

```python
interpretation = ClassificationInterpretation.from_learner(learner)
interpretation.plot_confusion_matrix()
```

This will compare how the model labeled the data during inference, and how the data is actually labeled.

This way, you can see elements in your data that are:
- incorrectly labeled
- hard to be recognized

Elements that are wrongly labeled have a high confidence score (model is sure) and a high loss (actual data label is totally off from what the model thinks).

### Top losses

```python
interpretation.plot_top_losses()
```

### Clean data

This will display a widget where you can fix the labels on your data

```python
cleaner = ImageClassifierCleaner(learner)
cleaner
```

then you save your changes

```python
for idx in cleaner.delete(): cleaner.fns[idx].unlink()
for idx, cat in cleaner.change(): shutil.move(str(cleaner.fns[idx]), path/ctr)
```
