import { useSpacers } from "@/components/ui-kit/core/use-spacers";
import { ExperienceSection } from "./experience-section";
import { IntroSection } from "./intro-section";
import { Inter } from 'next/font/google';
import { EventsSection } from "./events-section";
import { EducationSection } from "./education-section";
 
const inter = Inter({ subsets: ['latin'] });

export function IndexTemplate() {
  const spacers = useSpacers();

  return <>
  <style jsx global>
    {`
    body {
      font-family: ${inter.style.fontFamily};
      font-size: 14px;
    }

    blockquote {
      margin-top: 0;
      margin-left: 0;
      margin-right: 0;
      margin-bottom: ${spacers.base};
    }

    blockquote p {
      margin-top: 0;
      margin-bottom: 0;
    }

    h4 {
      margin: 0;
    }

    h1,
    h2,
    h3,
    h5,
    h6,
    ul,
    p {
      margin-top: 0;
      margin-bottom: ${spacers.base};
    }
    `}
  </style>
  <IntroSection />
  <ExperienceSection />
  <EventsSection />
  <EducationSection />
  </>
}