import { useColors } from "@/components/ui-kit/core/use-colors";
import { useSpacers } from "@/components/ui-kit/core/use-spacers";
import ReactMarkdown from "react-markdown";

export function EducationSection() {
  const colors = useColors();
  const spacers = useSpacers();

  return <>
  <style jsx global>
    {`
    .education-section h3 {
      background-color: ${colors.successMuted};
      padding: ${spacers.base};
    }
    `}
  </style>
  <ReactMarkdown className="education-section">
    {`## Education

### Academia Nacional de CiberSegurança

> Bootcamp | Certificate, Computer and Information Systems Security/Information Assurance

> Mar 2022 - Oct 2022

National Academy for Cyber Security. With a duration of 500 hours over 8 months, it covered the following subjects: CyberCrime, Computer Systems, Operating Systems, Databases, Network Programming, Vulnerabilities, Information Security, Risk Management, Intrusion Detection, Malware Analysis, OSINT, Forensics, SIEM, Incident Response, Information Warfare, Encryption, Electronics, GDPR and Telecommunications Security.

### Academia de Código

> Bootcamp | Full-stack development

> Sep 2016 - Jan 2017

14-week coding bootcamp aimed at teaching Java and Javascript to a class of 17 selected people, making them full-stack developers ready to work.

### Escola Artística António Arroio

> High-school | Graphic Design

> 2012 - 2015`}
  </ReactMarkdown>
  </>
}