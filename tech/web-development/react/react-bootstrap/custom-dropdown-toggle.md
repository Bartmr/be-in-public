```tsx
export function Message() {

  const _CustomToggle: ForwardRefRenderFunction<
    HTMLDivElement,
    { onClick: (e: ReactMouseEvent<HTMLDivElement, MouseEvent>) => void }
  > = ({ onClick }, ref) => (
    <div
      onClick={(e) => {
        e.preventDefault();
        onClick(e);
      }}
      ref={ref}
    >
      <FontAwesomeIcon icon={faEllipsis} />
    </div>
  );

  const CustomToggle = forwardRef(_CustomToggle);

  return <Dropdown>
    <Dropdown.Toggle
      as={CustomToggle}
      id="dropdown-custom-components"
    >
      Custom toggle
    </Dropdown.Toggle>
    <Dropdown.Menu>
      {props.moreActions.map((action) => {
        return (
          <Dropdown.Item
            key={action.label}
            onClick={(e) => {
              action.onClick();
            }}
            className={`${
              action.color
                ? `dropdown-item-${action.color}`
                : ""
            }`}
          >
            <div className="dropdown-label">{action.label}</div>
            {action.icon ? (
              <div className="dropdown-icon">{action.icon}</div>
            ) : null}{" "}
          </Dropdown.Item>
        );
      })}
    </Dropdown.Menu>
  </Dropdown>
                
  );
}
```