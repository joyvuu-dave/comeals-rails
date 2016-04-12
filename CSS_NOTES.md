
# Notes

### https://css-tricks.com/inheriting-box-sizing-probably-slightly-better-best-practice/
```
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
```

### Flex
```
.row {
  display: flex;
}
```

12 Properties
=============

### Axes
flex-direction
  - default value: row
justify-content
  - helps distribute extra free space leftover
align-items
  - default value: stretch
align-self

### Lines
flex-wrap
  - default: nowrap
### Directions
order
flex-flow
  flex-direction
  flex-wrap

### Dimensions
flex-grow: https://css-tricks.com/flex-grow-is-weird/
  - initial value: 0, must be a number
  - not what you think it is
  - un-needed if you always fill the row
  - "...rather than telling the browser how wide an element should be,
     flex-grow determines how the remaining space is distributed amongst
     the flex items and how big the share is each item receives..."
flex-shrink
  - initial value: 1, must be a number
  - don't really get it
flex-basis
  - initial value: auto
  - can be number or percentage
  - also: max-content, min-content, fit-content, fill
    - don't see anything about this
flex: above 3 properties - spec recommends using this shorthand
align-content
  - has no effect when the flexbox has only a single line
