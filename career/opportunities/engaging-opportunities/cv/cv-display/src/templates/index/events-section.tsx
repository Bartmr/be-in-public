import { useColors } from "@/components/ui-kit/core/use-colors";
import { useSpacers } from "@/components/ui-kit/core/use-spacers";
import ReactMarkdown from "react-markdown";

export function EventsSection() {
  const colors = useColors();
  const spacers = useSpacers();

  return <>
  <style jsx global>
    {`
    .events-section h3 {
      background-color: ${colors.infoMuted};
      padding: ${spacers.base};
    }
    `}
  </style>
  <ReactMarkdown className="events-section">
    {`## Events

### Academia de Código - Let's Talk Github

> May 3rd 2023

> 📼 https://www.youtube.com/watch?v=YfmfiQJIG5E

Gave a workshop with Academia de Código to 90 students, about the wonders of Github and text, and how you can use it to showcase your work and automate your life.


### Meetup DevPT - Estirador

> July 15th 2021

> 📼 https://www.youtube.com/watch?v=vDrOcHQzyP8&t=5931s

Gave a presentation about my project \`Estirador\`, an updatable boilerplate that can help you centralize all non-business related code of your projects in a single place.

### Eddisrupt - Develop a React app

> March 21st 2019

Gave a workshop on how to build a React application from scratch with React Context, to a class of both bootcamp students and experienced developers.`}
  </ReactMarkdown>
  </>
}