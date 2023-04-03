import React, { useCallback, useContext, useEffect, useState } from "react";

import {
    Box,
    Button,
    Flex,
    Image,
    Heading,
    Stack,
    Center
} from '@chakra-ui/react';

export default function Home() {

    const gotchis = async () => {
        console.log("Hola");
        window.location.href = `/gotchis`;
    }

    return (
        <Center>
            <>
                <div style={{ width: '100%' }}>
                    <Flex
                        align="center"
                        justify={{ base: "center", md: "space-around", xl: "space-between" }}
                        direction={{ base: "column-reverse", md: "row" }}
                        wrap="no-wrap"
                        minH="70vh"
                        px={8}
                        mb={16}
                    >
                        <Stack
                            spacing={4}
                            w={{ base: "80%", md: "40%" }}
                            align={["center", "center", "flex-start", "flex-start"]}
                        >
                            <Heading
                                as="h1"
                                size="xl"
                                fontWeight="bold"
                                color="primary.800"
                                textAlign={["center", "center", "left", "left"]}
                            >
                                ICP Gotchi
                            </Heading>
                            <Heading
                                as="h2"
                                size="md"
                                color="primary.800"
                                opacity="0.8"
                                fontWeight="normal"
                                lineHeight={1.5}
                                textAlign={["center", "center", "left", "left"]}
                            >
                                Para consusltar los gotchis creados y minar nuevos, de clic en siguiente.
                            </Heading>
                            <Button
                                bg='tomato'
                                colorScheme="primary"
                                borderRadius="8px"
                                py="4"
                                px="4"
                                lineHeight="1"
                                size="md"
                                onClick={async () => { gotchis(); }}
                            >
                                Siguiente
                            </Button>
                        </Stack>
                        <Box w={{ base: "80%", sm: "60%", md: "50%" }} mb={{ base: 12, md: 0 }}>
                            <Image src={"https://images.alphacoders.com/112/thumb-1920-1129289.jpg"} size="100%" rounded="1rem" shadow="2xl" mx="auto" />
                        </Box>
                    </Flex>
                </div>
            </>
        </Center>
    )
}
