// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file
/// @brief
/// @author Nobuyasu Koga

#ifndef INCLUDED_protocols_jd2_parser_BluePrint_FWD_HH
#define INCLUDED_protocols_jd2_parser_BluePrint_FWD_HH

#include <utility/pointer/owning_ptr.hh>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

namespace protocols {
namespace jd2 {
namespace parser {

class BluePrint;
typedef utility::pointer::shared_ptr< BluePrint > BluePrintOP;
typedef utility::pointer::shared_ptr< BluePrint const > BluePrintCOP;

} // parser
} // jd2
} // protocols

#endif